RSpec.describe Rxdt::Actions::Set_Attributes do
  it "can replace a node" do
    doc = Rxdt::Document.new <<~DOC
                               <?xml version="1.0"?>                                
                               <root>
                                 <div oldAttr="leave-me-alone" matchedAttr="update-me">
                                  Content stays the same
                                 </div>
                               </root>
                             DOC

    insert = Rxdt::Transform.new <<~DOC
                                   <?xml version="1.0"?>
                                   <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                                     <div xdt:Transform="SetAttributes" matchedAttr="updated" newAttr="created">
                                     Content stays the same
                                     </div>
                                   </root>
                                 DOC

    #TODO: Attribute order is wrong
    expected = Rxdt::Document.new <<~DOC
                                    <?xml version="1.0"?>
                                    <root>
                                      <div matchedAttr="updated" newAttr="created" oldAttr="leave-me-alone">
                                        Content stays the same
                                      </div>
                                    </root>
                                  DOC

    expect(doc.apply insert).to eq(expected)
  end
end
