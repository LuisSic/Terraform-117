const AWS = require('aws-sdk');
const uuid = require('uuid');
AWS.config.update({region: 'us-east-1'});
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = (event, context, callback) => {
    const key = JSON.parse(event.body);
    console.log(key);
    var params = {  
        TableName: 'Games',  
        Item: {
            gameId: uuid.v1(),
            gameTitle: key.gameTitle,
            gameDescription: key.gameDescription
            
        } 
      }

    dynamo.put(params, function (err, data) {
        if (err) {
            console.error("Unable to add item. Error JSON:", JSON.stringify(err, null, 2));
            callback(err, null);
        } else {
            var response = {
                statusCode: 200,
                isBase64Encoded: false
            };
            console.log("Added item:", JSON.stringify(data, null, 2));
            callback(null, response);
        }
    });
};