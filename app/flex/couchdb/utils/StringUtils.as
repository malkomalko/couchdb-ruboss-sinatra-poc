package couchdb.utils{
  public final class StringUtils{
	public static function generateRandomString(newLength:uint = 1, userAlphabet:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):String{
	  var alphabet:Array = userAlphabet.split("");
	  var alphabetLength:int = alphabet.length;
	  var randomLetters:String = "";
	  for (var i:uint = 0; i <newLength; i++){
		randomLetters += alphabet[int(Math.floor(Math.random() * alphabetLength))];
	  }
	  return randomLetters;
	}
  }
}