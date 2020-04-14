const AWS = require('aws-sdk');
AWS.config.update({region: 'us-east-1'});
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = (event, context, callback) => {
    const body = JSON.parse(event.body);
    var params = {  
        TableName: 'Games',  
        Key: {
            'gameId': event.queryStringParameters.gameId
        },
        UpdateExpression: "set gameDescription = :r",
        ExpressionAttributeValues:{
            ":r":body.gameDescription,
        },
        ReturnValues:"UPDATED_NEW"
      }

    dynamo.update(params, function (err, data) {
        if (err) {
            console.error("Unable to update item. Error JSON:", JSON.stringify(err, null, 2));
            callback(err, null);
        } else {
            var response = {
                statusCode: 201,
                isBase64Encoded: false
            };
            console.log("UpdateItem succeeded:", JSON.stringify(data, null, 2));
            callback(null, response);
        }
    });
};