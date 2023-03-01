part of category_keyword; 
 
// lib/repository.dart 
 
class Repository extends CoreRepository { 
 
  static const REPOSITORY = "Repository"; 
 
  Repository([String code=REPOSITORY]) : super(code) { 
    var domain = new Domain("Category"); 
    domains.add(domain); 
    add(new CategoryDomain(domain)); 
 
  } 
 
} 
 
