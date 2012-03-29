require 'oculus'

describe Oculus::Connection do
  before(:all) do
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "test")
    client.query %[
      CREATE TABLE IF NOT EXISTS oculus_users (
        id MEDIUMINT NOT NULL AUTO_INCREMENT,
        name VARCHAR(255),
        PRIMARY KEY (id)
      )
  ]

    client.query 'TRUNCATE oculus_users'

    client.query %[
      INSERT INTO oculus_users (name) VALUES ('Paul'), ('Amy'), ('Peter')
    ]
  end

  subject { Oculus::Connection::Mysql2.new(:database => 'test') }

  it "fetches a result set" do
    subject.execute("SELECT * FROM oculus_users").should == [['id', 'name'], [1, 'Paul'], [2, 'Amy'], [3, 'Peter']]
  end
end