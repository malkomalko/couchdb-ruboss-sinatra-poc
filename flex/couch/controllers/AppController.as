package couch.controllers {
	
  import org.ruboss.Ruboss;
  import org.ruboss.controllers.RubossApplicationController;
  import org.ruboss.utils.RubossUtils;
  
  import couch.commands.*;
  import couch.models.*;

  public class AppController extends RubossApplicationController {
    private static var controller:AppController;
    
    public static var models:Array = [Project, Task];
    
    public static var commands:Array = [];
    
    public function AppController(enforcer:SingletonEnforcer, extraServices:Array,
      defaultServiceId:int = -1) {
  		super(commands, models, extraServices, defaultServiceId);
    }
    
    public static function get instance():AppController {
      if (controller == null) initialize();
      return controller;
    }
    
    public static function initialize(extraServices:Array = null, defaultServiceId:int = -1,
      airDatabaseName:String = null):void {
      if (!!RubossUtils.isEmpty(airDatabaseName)) Ruboss.airDatabaseName = airDatabaseName;
      controller = new AppController(new SingletonEnforcer, extraServices,
        defaultServiceId);
    }
  }
}

class SingletonEnforcer {}
