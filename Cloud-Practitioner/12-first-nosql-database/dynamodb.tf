resource "aws_dynamodb_table" "user_video_history_ddb" {
  name           = "UserVideoHistory"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "userId"
  range_key      = "lastDateWatched"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "lastDateWatched"
    type = "N"
  }

  tags = {
    Name = "UserVideoHistory"
  }
}

resource "aws_dynamodb_table_item" "user_video_history_ddb_item" {
  table_name = aws_dynamodb_table.user_video_history_ddb.name
  hash_key   = aws_dynamodb_table.user_video_history_ddb.hash_key
  range_key  = aws_dynamodb_table.user_video_history_ddb.range_key


  item = <<ITEM
{
"userId": {"S": "12345-abcd-6789"},
"lastDateWatched": {"N": "1619156406"},
"videoId": {"S": "9875-djac-1859"},
"preferredLanguage": {"S": "English"},
"supportedDeviceTypes": {"L": [{ "S" : "Amazon Fire TV" }, { "S" : "Amazon Fire Tablet" }]},
"lastStopTime": {"N": "90"},
"newUserId": {"S": "123456-abcde-7890"},
"rating": {"N": "5"}
}
ITEM
}
