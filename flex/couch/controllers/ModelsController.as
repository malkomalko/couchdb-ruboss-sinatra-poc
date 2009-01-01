package couch.controllers {
	
	//models
	import couch.models.Project;
	import couch.models.Task;
  
  //ruboss  	
  import org.ruboss.Ruboss;
  import org.ruboss.collections.RubossCollection;
  import org.ruboss.events.CacheUpdateEvent;
  
  [Bindable]
  public class ModelsController {
  	
  	private static var controller:ModelsController;
  	
  	public var _projects:RubossCollection;
    public var _tasks:RubossCollection;
	  
    public function ModelsController(enforcer:SingletonEnforcer) {
      Ruboss.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      Ruboss.models.index(Project);
			Ruboss.models.index(Task);
    }

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      if (event.isFor(Project)) {
        _projects = Ruboss.models.cached(Project);
      } else if (event.isFor(Task)) {
      	_tasks = Ruboss.models.cached(Task);
      }
    }
    
    public static function get instance():ModelsController {
      initialize();
      return controller;
    }
      
    public static function initialize():void {
      if (!controller) controller = new ModelsController(new SingletonEnforcer);      
    }
    
    public static function reset():void {
      controller = null;  
    }
  }
}

class SingletonEnforcer {}