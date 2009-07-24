require File.dirname(__FILE__) + '/../spec_helper'

describe RouteHandlerTags do
  
  before do
    @page = Page.create!(
      :title => 'New Page',
      :slug => 'page',
      :breadcrumb => 'New Page',
      :status_id => '100'
    )
  end
  
  describe "<r:route_param />" do
    it "should show Route Handler Parameter by <r:route_param /> tag" do
       @page.route_handler_params = {:name => 'something'}
       @page.should render("<r:route_param name='name' />").as('something')
     end


     it "should substitute route handler params to any attribute of any tag" do
       @page.route_handler_params = {:name => 'something', :something => "else"}
       @page.should render("<r:route_param name='_:name:_' />").as('else')
     end
    
  end
   
  describe "<r:if_route_param>" do
    it "should render tag contents if the parameter exists" do
      @page.route_handler_params = {:name => 'something'}
      @page.should render("<r:if_route_param name='name'>Hello</r:if_route_param>").as('Hello')
    end
    
    it "should not render tag contents if the parameter does not exist" do
      @page.route_handler_params = {:name => 'something'}
      @page.should render("<r:if_route_param name='notfound'>Hello</r:if_route_param>").as('')
    end
    
  end
  
  describe "<r:unless_route_param>" do
    it "should not render tag contents if the parameter exists" do
      @page.route_handler_params = {:name => 'something'}
      @page.should render("<r:unless_route_param name='name'>Hello</r:unless_route_param>").as('')
    end
    
    it "should render tag contents if the parameter does not exists" do
      @page.route_handler_params = {:name => 'something'}
      @page.should render("<r:unless_route_param name='notfound'>Hello</r:unless_route_param>").as('Hello')
    end
  end
end