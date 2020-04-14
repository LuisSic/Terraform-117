const AWS = require('aws-sdk');
AWS.config.update({region: 'us-east-1'});
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = (event, context, callback) => {
    var params = {  
        TableName: 'Games',  
        Key: {
            'gameId': event.queryStringParameters.gameId
        }
      }

    dynamo.get(params, function (err, data) {
        if (err) {
            console.error("Unable to read item. Error JSON:", JSON.stringify(err, null, 2));
            callback(err, null);
        } else {
            var response = {
                statusCode: 200,
                body: JSON.stringify(data.Item),
                isBase64Encoded: false
            };
            console.log("GetItem succeeded:", JSON.stringify(data, null, 2));
            callback(null, response);
        }
    });
};
