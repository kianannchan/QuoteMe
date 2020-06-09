import  '../web/config.dart';
import  '../web/quote.dart';
import 'package:test/test.dart';


void main() async{
  var configC  = config();
  var quoteC = Quote();
  await quoteC.fetchQuote();

  group('favourite collection', () {
    test('Not sufficient upload limit and no duplicates', () {
      configC.setUploadLimit(0);
      var uploadLimit = configC.getUploadLimit();
      var favQuota = configC.verifyFavQuota(quoteC);
      expect(favQuota, true);
      expect(uploadLimit, 0);

    });
    test('Sufficient upload limit and no duplicates', () {
      configC.setUploadLimit(5);
      //configC.removeFavQuote(quoteC.getId());
      var uploadLimit = configC.getUploadLimit();
      var favQuota = configC.verifyFavQuota(quoteC);
      expect(favQuota, true);
      expect(uploadLimit, 5);
    });
    test('Not sufficient upload limit and duplicates', () {
      configC.setUploadLimit(0);
      configC.setFavQuote(quoteC.toJson());
      var uploadLimit = configC.getUploadLimit();
      var favQuota = configC.verifyFavQuota(quoteC);
      expect(favQuota, false);
      expect(uploadLimit, 0);
    });
    test('Sufficient upload limit and duplicates', () {
      configC.setUploadLimit(5);
      var uploadLimit = configC.getUploadLimit();
      var favQuote= configC.verifyFavQuota(quoteC);
      expect(favQuote, false);
      expect(uploadLimit, 5);
    });
  });

  group('Remove collection', ()
   {
    test('invalid id and collection still remains', () {
      configC.removeFavQuote('dummyId');
      var favQuote = configC.verifyFavQuota(quoteC);
      expect(favQuote, false);
    });
    test('valid id and collection clear', () {
      configC.removeFavQuote(quoteC.getId());
      var favQuote = configC.verifyFavQuota(quoteC);
      expect(favQuote, true);
    });
  });

  group('Color Coding', ()
  {
    test('upload limit at 5 count', () {
      configC.setUploadLimit(5);
      var percent = configC.percentProgress();
      var color = configC.colorProgress(percent);
      expect(percent, 50);
      expect(color, '#F99F2D');
    });
    test('upload limit at 7 count', () {
      configC.setUploadLimit(7);
      var percent = configC.percentProgress();
      var color = configC.colorProgress(percent);
      expect(percent, 70);
      expect(color, '#2D90F9');
    });
    test('upload limit at 2 count', () {
      configC.setUploadLimit(2);
      var percent = configC.percentProgress();
      var color = configC.colorProgress(percent);
      expect(percent, 20);
      expect(color, '#F9452D');
    });
  });
}
