package couch.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(name="task")]
  [Bindable]
  public class Task extends RubossModel {
    public static const LABEL:String = "name";

    public var name:String;

    public function Task() {
      super(LABEL);
    }
  }
}
