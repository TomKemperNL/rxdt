RSpec.describe Rxdt::Actions::Remove do
  it "can remove a node" do
    doc = Rxdt::Document.new <<~DOC
                               <?xml version="1.0"?>                                
                               <root>
                                 <div>
                                   Old Content Here
                                 </div>
                               </root>
                             DOC

    insert = Rxdt::Transform.new <<~DOC
                                   <?xml version="1.0"?>
                                   <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                                     <div xdt:Transform="Remove" />
                                   </root>
                                 DOC

    expected = Rxdt::Document.new <<~DOC
                                    <?xml version="1.0"?>
                                    <root>                                      
                                    </root>
                                  DOC

    expect(doc.apply insert).to eq(expected)
  end
end
