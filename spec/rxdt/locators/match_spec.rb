RSpec.describe Rxdt::Locators::Match do
  it "can replace a node in a collection" do
    doc = Rxdt::Document.new <<~DOC
                               <?xml version="1.0"?>                                
                               <root>
                                 <collection>
                                   <item id="1">Left alone</item>
                                   <item id="2">Old Content</item>                                   
                                   <item id="3">Left alone</item>
                                 </collection>
                               </root>
                             DOC

    insert = Rxdt::Transform.new <<~DOC
                                   <?xml version="1.0"?>
                                   <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">                                     
                                    <collection>                                      
                                      <item id="2" xdt:Transform="Replace" xdt:Locator="Match(id)">New Content</item>
                                    </collection>                                     
                                   </root>
                                 DOC

    expected = Rxdt::Document.new <<~DOC
                                    <?xml version="1.0"?>
                                    <root>
                                      <collection>
                                        <item id="1">Left alone</item>
                                        <item id="2">New Content</item>                                   
                                        <item id="3">Left alone</item>
                                      </collection>
                                    </root>
                                  DOC

    expect(doc.apply insert).to eq(expected)
  end

  it "can replace a nested node in a collection with a locator somewhere else" do
    doc = Rxdt::Document.new <<~DOC
                               <?xml version="1.0"?>                                
                               <root>
                                 <collection>
                                  <item id="1">Left alone</item>
                                  <item id="2">
                                    <part1>Old Content</part1>
                                    <part2>Left alone</part2>
                                  </item>
                                  <item id="3">Left alone</item>
                                 </collection>
                               </root>
                             DOC

    insert = Rxdt::Transform.new <<~DOC
                                   <?xml version="1.0"?>
                                   <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">                                     
                                    <collection>                                      
                                      <item id="2" xdt:Locator="Match(id)">
                                        <part1 xdt:Transform="Replace">Updated</part1>
                                      </item>
                                    </collection>                                     
                                   </root>
                                 DOC

    expected = Rxdt::Document.new <<~DOC
                                    <?xml version="1.0"?>
                                    <root>
                                      <collection>
                                        <item id="1">Left alone</item>
                                        <item id="2">
                                          <part1>Updated</part1>
                                          <part2>Left alone</part2>
                                        </item>
                                        <item id="3">Left alone</item>
                                      </collection>
                                    </root>
                                  DOC

    expect(doc.apply insert).to eq(expected)
  end
end
