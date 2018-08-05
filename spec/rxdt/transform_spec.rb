RSpec.describe Rxdt::Transform do
  it "requires a non-nil arg" do
    expect { Rxdt::Transform.new(nil) }.to raise_error RxdtError
  end

  it "requires a nonempty root element" do
    expect { Rxdt::Transform.new "" }.to raise_error RxdtError
  end

  it "requires a root element with the xdt namespace" do
    expect { Rxdt::Transform.new "<root xmlns:bla=\"http://bla.bla.bla\" />" }.to raise_error RxdtError
  end

  it "can construct a standard root element" do
    expect { Rxdt::Transform.new "<root xmlns:xdt=\"http://schemas.microsoft.com/XML-Document-Transform\" />" }.to_not raise_error
  end

  it "can construct a root element with a non-standard abbreviation" do
    expect { Rxdt::Transform.new "<root xmlns:bla=\"http://schemas.microsoft.com/XML-Document-Transform\" />" }.to_not raise_error
  end

  context "when transform has actions" do
    let :transform do
      Rxdt::Transform.new <<~DOC
                            <root xmlns:xdt=\"http://schemas.microsoft.com/XML-Document-Transform\">
                              <div xdt:Transform=\"Replace\">
                                Replace Me!
                              </div>
                              <div>
                                <div xdt:Transform=\"Insert\">
                                  Insert Me!
                                </div>
                              </div>                              
                            </root>
                          DOC
    end

    it "can find replace action" do
      expect(transform.actions).to include(a_kind_of(Rxdt::Actions::Replace))
    end

    it "can find (nested) insert action" do
      expect(transform.actions).to include(a_kind_of(Rxdt::Actions::Insert))
    end
  end
end
