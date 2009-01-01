package couch.models {
  import org.ruboss.models.RubossModel;
  
  [Resource(name="server_settings")]
  [Bindable]
  public class ServerSetting extends RubossModel {
    public static const LABEL:String = "environment";

    public var environment:String;

    public function ServerSetting() {
      super(LABEL);
    }
  }
}