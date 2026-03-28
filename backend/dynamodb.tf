resource "aws_dynamodb_table" "my_dynamodb" {
  name = "xdevopsman-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  depends_on = [ aws_s3_bucket.my_bucket ]

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "xdevopsman-dynamodb"
  }
}