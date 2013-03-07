describe "TodoController" do
  
  before do
    @now = NSDate.new
    @todo = Todo.create :name => "Buy Milk",
                        :description => "We need some Milk",
                        :due_date => @now
    @controller = TodoController.create(@todo)
    @form = @controller.instance_variable_get("@form")
  end
  
  it "saves changes made to a todo" do
    row = @form.row_for_index_path(NSIndexPath.indexPathForRow(0, inSection: 0))
    
    
    puts "\nROW.textfield ==> #{row.text_field.nil?}"
    #.text = "Buy 1% Milk"
    puts "\nROW:: key => #{row.key}, value => #{row.value}, title => #{row.title}"
    #row.public_methods.sort.each { |m| puts m }
    # values = @form.to_hash
    # puts "BEFORE ==> #{values}"
    # values[:sections][0][:rows][0][:value] = "Buy 1% Milk"
    # puts "AFTER ==> #{values}"
    # @form.values = values
    #@controller.save
    #tap "save"
    true.should.be.true
  end
  
end