package couchdb.controllers {
	
	//models
	import couchdb.models.Location;
  import couchdb.models.Note;
  import couchdb.models.Project;
  import couchdb.models.Task;
  import couchdb.models.User;
	
	//ruboss
  import org.ruboss.Ruboss;
  import org.ruboss.collections.RubossCollection;
  import org.ruboss.events.CacheUpdateEvent;
  
  [Bindable]
  public class ModelsController {
        
    private static var controller:ModelsController;

    public var locations:RubossCollection;
    public var notes:RubossCollection;
    public var projects:RubossCollection;
    public var tasks:RubossCollection;
    public var users:RubossCollection;
    
    public function ModelsController(enforcer:SingletonEnforcer) {
      Ruboss.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
      Ruboss.models.index(Location);
      Ruboss.models.index(Note);
      Ruboss.models.index(Project);
      Ruboss.models.index(Task);
      Ruboss.models.index(User);
    }

    private function onCacheUpdate(event:CacheUpdateEvent):void {
      if (event.isFor(Location)) {
        locations = Ruboss.models.cached(Location);
      } else if (event.isFor(Note)) {
				notes = Ruboss.models.cached(Note);
      } else if (event.isFor(Project)) {
				projects = Ruboss.models.cached(Project);
      } else if (event.isFor(Task)) {
				tasks = Ruboss.models.cached(Task);
      } else if (event.isFor(User)) {
				users = Ruboss.models.cached(User);
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