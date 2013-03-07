class TodoController < Formotion::FormController
  attr_accessor :todo
  
  def self.create(todo)
    @form = Formotion::Form.new(todo.to_formotion('Edit your ToDo'))
    controller = self.alloc.initWithForm(@form)
    controller.todo = todo
    controller
  end
  
  def viewDidLoad
    super
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'save')
  end

  def save
    data = @form.render
    @todo.from_formotion!(data)
    @todo.save
    
    app = UIApplication.sharedApplication
    delegate = app.delegate
    controller = delegate.instance_variable_get("@todos_controller")
    view = controller.instance_variable_get("@table")
    view.setNeedsDisplay
    
    self.navigationController.popToRootViewControllerAnimated(true)
  end
end