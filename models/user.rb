class User < CouchModel
  key_accessor :login, :first_name, :last_name, :email
end