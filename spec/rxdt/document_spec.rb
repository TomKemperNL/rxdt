RSpec.describe Rxdt::Document do
  it "can apply the empty transform" do
    source = Rxdt::Document.new "<root><someElement>bla</someElement></root>"
    transform = Rxdt::Transform.new "<root xmlns:xdt=\"http://schemas.microsoft.com/XML-Document-Transform\" />"
    result = Rxdt::Document.new "<root><someElement>bla</someElement></root>"
    expect(source.apply transform).to eq result
  end

  it "compares equality by value" do
    source = Rxdt::Document.new "<root><someElement>bla</someElement></root>"
    result = Rxdt::Document.new "<root><someElement>bla</someElement></root>"
    expect(source).to eq result
  end

  it "ignores insignificant whitespace" do
    source = Rxdt::Document.new "<root>  <someElement>bla</someElement>  </root>"
    result = Rxdt::Document.new "<root><someElement> bla</someElement></root>"
    expect(source).to eq result
  end

  it "does not equal nil" do
    source = Rxdt::Document.new "<root><someElement>bla</someElement></root>"
    expect(source).to_not eq nil
  end
end
