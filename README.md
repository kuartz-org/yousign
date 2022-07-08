# Yousign

Ruby wrapper for Yousign API.

## Installation

```ruby
# Gemfile
gem "yousign", github: "kuartz-org/yousign"
```

### Configuration

For Rails:

```ruby
# config/initializers/yousign.rb

Yousign.configure do |config|
  config.api_key = Rails.application.credentials.yousign[:api_key]

  if Rails.env.production?
    config.base_url = "https://api.yousign.com"
    config.webapp_url = "https://webapp.yousign.com"
  end
end
```

## Usage

[📘 Yousign api documentation](https://dev.yousign.com/)

### Procedure creation

```ruby
# Step 1 - Upload the files
yousign_file = Yousign::File.upload(
  filename: "proposal.pdf",
  file: File.new("insurances/proposal.pdf")
)
# => <#Yousign::File...>

# Step 2 - Create the procedure
Yousign::Procedure.create(
  name: "My first procedure",
  description: "Awesome! Here is the description of my first procedure",
  members: [
    {
      firstname: "John",
      lastname: "Doe",
      email: "john.doe@yousign.fr",
      phone: "+33612345678",
      file_objects: [
        {
          file: yousign_file.id,
          page: 2,
          position: "230,499,464,589",
          mention: "Read and approved",
          mention2: "Signed by John Doe"
        }
      ]
    }
  ]
)
# => <#Yousign::Procedure...>
```
