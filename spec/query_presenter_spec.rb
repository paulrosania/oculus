require_relative '../lib/oculus/query'
require_relative '../lib/oculus/presenters/query_presenter'

describe Oculus::Presenters::QueryPresenter do
  let(:query) { Oculus::Query.new }
  let(:presenter) { Oculus::Presenters::QueryPresenter.new(query) }

  it "should delegate to the underlying query" do
    query.description = 'foo'
    presenter.description.should == 'foo'
  end

  it "has a formatted date" do
    query.date = Time.mktime(2010, 1, 1, 12, 34)
    presenter.formatted_date.should == '2010-01-01 12:34'
  end

  it "reports finished queries" do
    query.stub(:ready?).and_return(true)
    presenter.status.should == 'done'
  end

  it "reports loading queries" do
    query.stub(:ready?).and_return(false)
    presenter.status.should == 'loading'
  end
end