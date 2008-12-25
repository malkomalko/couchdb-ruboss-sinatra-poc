package couch.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(name="project")]
  [Bindable]
  public class Project extends RubossModel {
    public static const LABEL:String = "title";

    public var title:String;
    //public var name:String;
    //public var body:String;

    public function Project() {
      super(LABEL);
    }
  }
}