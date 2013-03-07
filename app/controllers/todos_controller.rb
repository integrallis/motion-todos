class TodosController < UIViewController
  
  def viewDidLoad
    super
    self.title = "My ToDos"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    @table.dataSource = self
    @table.delegate = self
    
    @todos = Todo.all

    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'todoChanged:',
                                                         name: 'MotionModelDataDidChangeNotification',
                                                         object: nil)
  end
  
  def todoChanged(notification)
    case notification.userInfo[:action]
      when 'add'
      when 'update'
        todo = notification.object
        row = todo.id - 1
        path = NSIndexPath.indexPathForRow(row, inSection:0)
        @table.reloadRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationAutomatic)
      when 'delete'  
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @todos.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:nil)
    cell.textLabel.text = @todos[indexPath.row].name
    cell
  end
  
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    todo = @todos[indexPath.row]
    controller = TodoController.create(todo)
    self.navigationController.pushViewController(controller, animated: true)
  end
  
end