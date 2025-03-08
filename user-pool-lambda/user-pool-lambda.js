const AWS = require('aws-sdk');
const cognito = new AWS.CognitoIdentityServiceProvider();

const USER_POOL_ID = process.env.USER_POOL_ID;
const CLIENT_ID = process.env.CLIENT_ID;

/**
 * Lambda handler function
 */
exports.handler = async (event) => {
  console.log("Event received:", JSON.stringify(event)); // Log the incoming event
  let response;

  try {
    const body = JSON.parse(event.body); // Parse incoming JSON body
    const { action, email, password } = body;

    if (action === "register") {
      console.log(`Registering user: ${email}`); // Log registration request
      response = await registerUser(email, password);
    } else if (action === "login") {
      console.log(`Logging in user: ${email}`); // Log login request
      response = await loginUser(email, password);
    } else {
      console.error(`Invalid action: ${action}`); // Log invalid action
      return {
        statusCode: 400,
        body: JSON.stringify({ message: "Invalid action. Use 'register' or 'login'." }),
      };
    }

    console.log("Successful response:", response); // Log successful response
    return {
      statusCode: 200,
      body: JSON.stringify(response),
    };

  } catch (error) {
    console.error("Error occurred:", error); // Log any errors
    return {
      statusCode: 500,
      body: JSON.stringify({ message: "An error occurred", error: error.message }),
    };
  }
};

/**
 * Register a new user in Cognito User Pool
 */
async function registerUser(email, password) {
  const params = {
    UserPoolId: USER_POOL_ID,
    Username: email,
    TemporaryPassword: password,
    MessageAction: "SUPPRESS",
    DesiredDeliveryMediums: ["EMAIL"],
    UserAttributes: [{ Name: "email", Value: email }],
  };

  console.log("Register user params:", params);
  const result = await cognito.adminCreateUser(params).promise();
  console.log("Cognito register response:", result);

  return { message: "User registered successfully", result };
}

/**
 * Authenticate user login
 */
async function loginUser(email, password) {
  const params = {
    AuthFlow: "USER_PASSWORD_AUTH",
    ClientId: CLIENT_ID,
    AuthParameters: {
      USERNAME: email,
      PASSWORD: password,
    },
  };

  console.log("Login user params:", params);
  const result = await cognito.initiateAuth(params).promise();
  console.log("Cognito login response:", result);

  return { message: "Login successful", result: result.AuthenticationResult };
}
