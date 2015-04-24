 
// test/category/keyword/category_keyword_category_test.dart 
 
import "package:test/test.dart"; 
//import "package:dartling/dartling.dart"; 
import "package:category_keyword/category_keyword.dart"; 
 
testCategoryKeywordCategory( 
    Repository repository, String domainCode, String modelCode) { 
  var domain; 
  var session; 
  var model; 
  var categories; 
  group("Testing Category.Keyword.Category", () { 
    domain = repository.getDomainModels(domainCode); 
    session = domain.newSession(); 
    model = domain.getModelEntries(modelCode); 
    //expect(model, isNotNull); 
    categories = model.categories; 
    //expect(categories.isEmpty, isTrue); 
    setUp(() { 
      model.init(); 
    }); 
    tearDown(() { 
      model.clear(); 
    }); 

    
 
  }); 
} 
 
void main() { 
  testCategoryKeywordCategory(new Repository(), "Category", "Keyword"); 
} 
 
