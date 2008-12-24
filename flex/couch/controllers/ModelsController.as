package couch.controllers {
  import org.ruboss.Ruboss;
  import org.ruboss.collections.RubossCollection;
  import org.ruboss.events.CacheUpdateEvent;
  
  [Bindable]
  public class ModelsController {
  	
  	private static var controller:ModelsController;
    
    public function ModelsController(enforcer:SingletonEnforcer) {
      Ruboss.models.addEventListener(CacheUpdateEvent.ID, onCacheUpdate);
    }

    private function onCacheUpdate(event:CacheUpdateEvent):void {

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