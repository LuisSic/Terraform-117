resource "aws_dynamodb_table" "sluis-dynamodb-table" {
    name = "Games"
    billing_mode = "PROVISIONED"
    read_capacity = 20
    write_capacity = 20
    hash_key = "gameId"
    attribute {
        name = "gameId"
        type = "S"
    }

    attribute {
        name = "gameTitle"
        type = "S"
    }

    attribute {
        name = "gameDescription"
        type = "S"
    }

    global_secondary_index {
        name               = "gameTitleIndex"
        hash_key           = "gameTitle"
        range_key          = "gameDescription"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "INCLUDE"
        non_key_attributes = ["gameId"]
  }
}


