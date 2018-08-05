RSpec.describe Rxdt::Actions::Insert do
  it "can insert a node" do
    doc = Rxdt::Document.new <<~DOC
                               <?xml version="1.0"?>
                               <root />
                             DOC

    insert = Rxdt::Transform.new <<~DOC
                                   <?xml version="1.0"?>
                                   <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                                     <div xdt:Transform="Insert">
                                       Some Content Here
                                     </div>
                                   </root>
                                 DOC

    expected = Rxdt::Document.new <<~DOC
                                    <?xml version="1.0"?>
                                    <root>
                                      <div>
                                        Some Content Here
                                      </div>
                                    </root>
                                  DOC

    expect(doc.apply insert).to eq(expected)
  end
end
