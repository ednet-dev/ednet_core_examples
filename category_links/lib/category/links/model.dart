 
part of category_links; 
 
// lib/category/links/model.dart 
 
class LinksModel extends LinksEntries { 
 
  LinksModel(Model model) : super(model); 
 
  void fromJsonToMemberEntry() { 
    fromJsonToEntry(categoryLinksMemberEntry); 
  } 
 
  void fromJsonToCategoryEntry() { 
    fromJsonToEntry(categoryLinksCategoryEntry); 
  } 
 
  void fromJsonToCommentEntry() { 
    fromJsonToEntry(categoryLinksCommentEntry); 
  } 
 
  void fromJsonToQuestionEntry() { 
    fromJsonToEntry(categoryLinksQuestionEntry); 
  } 
 
  void fromJsonToModel() { 
    fromJson(categoryLinksModel); 
  } 
 
  void init() { 
    initCategories(); 
    initMembers(); 
    initComments(); 
    initQuestions(); 
  } 
 
  void initMembers() { 
    var member1 = Member(members.concept); 
    member1.email = 'antonio@flores.com'; 
    member1.firstName = 'accident'; 
    member1.lastName = 'book'; 
    member1.startedOn = new DateTime.now(); 
    member1.receiveEmail = true; 
    member1.password = 'cash'; 
    member1.role = 'accomodation'; 
    member1.karma = 779.9208623816488; 
    member1.about = 'bank'; 
    members.add(member1); 
 
    var member1interests1 = Interest(member1.interests.concept); 
    member1interests1.description = 'place'; 
    var member1interests1Category = categories.random(); 
    member1interests1.category = member1interests1Category; 
    member1interests1.member = member1; 
    member1.interests.add(member1interests1); 
    member1interests1Category.interests.add(member1interests1); 
 
    var member1interests2 = Interest(member1.interests.concept); 
    member1interests2.description = 'brad'; 
    var member1interests2Category = categories.random(); 
    member1interests2.category = member1interests2Category; 
    member1interests2.member = member1; 
    member1.interests.add(member1interests2); 
    member1interests2Category.interests.add(member1interests2); 
 
    var member2 = Member(members.concept); 
    member2.email = 'matt@carter.com'; 
    member2.firstName = 'selfdo'; 
    member2.lastName = 'series'; 
    member2.startedOn = new DateTime.now(); 
    member2.receiveEmail = false; 
    member2.password = 'school'; 
    member2.role = 'capacity'; 
    member2.karma = -644; 
    member2.about = 'bank'; 
    members.add(member2); 
 
    var member2interests1 = Interest(member2.interests.concept); 
    member2interests1.description = 'observation'; 
    var member2interests1Category = categories.random(); 
    member2interests1.category = member2interests1Category; 
    member2interests1.member = member2; 
    member2.interests.add(member2interests1); 
    member2interests1Category.interests.add(member2interests1); 
 
    var member2interests2 = Interest(member2.interests.concept); 
    member2interests2.description = 'service'; 
    var member2interests2Category = categories.random(); 
    member2interests2.category = member2interests2Category; 
    member2interests2.member = member2; 
    member2.interests.add(member2interests2); 
    member2interests2Category.interests.add(member2interests2); 
 
    var member3 = Member(members.concept); 
    member3.email = 'anna@ruiz.com'; 
    member3.firstName = 'holiday'; 
    member3.lastName = 'end'; 
    member3.startedOn = new DateTime.now(); 
    member3.receiveEmail = false; 
    member3.password = 'sin'; 
    member3.role = 'sentence'; 
    member3.karma = 991.8764575503192; 
    member3.about = 'concern'; 
    members.add(member3); 
 
    var member3interests1 = Interest(member3.interests.concept); 
    member3interests1.description = 'security'; 
    var member3interests1Category = categories.random(); 
    member3interests1.category = member3interests1Category; 
    member3interests1.member = member3; 
    member3.interests.add(member3interests1); 
    member3interests1Category.interests.add(member3interests1); 
 
    var member3interests2 = Interest(member3.interests.concept); 
    member3interests2.description = 'children'; 
    var member3interests2Category = categories.random(); 
    member3interests2.category = member3interests2Category; 
    member3interests2.member = member3; 
    member3.interests.add(member3interests2); 
    member3interests2Category.interests.add(member3interests2); 
 
  } 
 
  void initCategories() { 
    var category1 = Category(categories.concept); 
    category1.name = 'yellow'; 
    category1.description = 'family'; 
    category1.approved = true; 
    categories.add(category1); 
 
    var category1webLinks1 = WebLink(category1.webLinks.concept); 
    category1webLinks1.subject = 'country'; 
    category1webLinks1.url = Uri.parse('http://code.google.com/p/dart-enumerators/'); 
    category1webLinks1.description = 'park'; 
    category1webLinks1.createdOn = new DateTime.now(); 
    category1webLinks1.updatedOn = new DateTime.now(); 
    category1webLinks1.approved = false; 
    category1webLinks1.category = category1; 
    category1.webLinks.add(category1webLinks1); 
 
    var category1webLinks2 = WebLink(category1.webLinks.concept); 
    category1webLinks2.subject = 'nothingness'; 
    category1webLinks2.url = Uri.parse('http://goodui.org/'); 
    category1webLinks2.description = 'wave'; 
    category1webLinks2.createdOn = new DateTime.now(); 
    category1webLinks2.updatedOn = new DateTime.now(); 
    category1webLinks2.approved = false; 
    category1webLinks2.category = category1; 
    category1.webLinks.add(category1webLinks2); 
 
    var category2 = Category(categories.concept); 
    category2.name = 'city'; 
    category2.description = 'city'; 
    category2.approved = true; 
    categories.add(category2); 
 
    var category2webLinks1 = WebLink(category2.webLinks.concept); 
    category2webLinks1.subject = 'discount'; 
    category2webLinks1.url = Uri.parse('http://www.codewars.com/'); 
    category2webLinks1.description = 'mile'; 
    category2webLinks1.createdOn = new DateTime.now(); 
    category2webLinks1.updatedOn = new DateTime.now(); 
    category2webLinks1.approved = true; 
    category2webLinks1.category = category2; 
    category2.webLinks.add(category2webLinks1); 
 
    var category2webLinks2 = WebLink(category2.webLinks.concept); 
    category2webLinks2.subject = 'dvd'; 
    category2webLinks2.url = Uri.parse('http://iznadsvih.blogspot.ca/2013/09/sarajevo-moje-voljeno_29.html'); 
    category2webLinks2.description = 'economy'; 
    category2webLinks2.createdOn = new DateTime.now(); 
    category2webLinks2.updatedOn = new DateTime.now(); 
    category2webLinks2.approved = true; 
    category2webLinks2.category = category2; 
    category2.webLinks.add(category2webLinks2); 
 
    var category3 = Category(categories.concept); 
    category3.name = 'lunch'; 
    category3.description = 'dvd'; 
    category3.approved = true; 
    categories.add(category3); 
 
    var category3webLinks1 = WebLink(category3.webLinks.concept); 
    category3webLinks1.subject = 'place'; 
    category3webLinks1.url = Uri.parse('https://github.com/vadimtsushko/angular_objectory_demo'); 
    category3webLinks1.description = 'service'; 
    category3webLinks1.createdOn = new DateTime.now(); 
    category3webLinks1.updatedOn = new DateTime.now(); 
    category3webLinks1.approved = false; 
    category3webLinks1.category = category3; 
    category3.webLinks.add(category3webLinks1); 
 
    var category3webLinks2 = WebLink(category3.webLinks.concept); 
    category3webLinks2.subject = 'edition'; 
    category3webLinks2.url = Uri.parse('http://restcountries.eu/'); 
    category3webLinks2.description = 'water'; 
    category3webLinks2.createdOn = new DateTime.now(); 
    category3webLinks2.updatedOn = new DateTime.now(); 
    category3webLinks2.approved = true; 
    category3webLinks2.category = category3; 
    category3.webLinks.add(category3webLinks2); 
 
  } 
 
  void initComments() { 
    var comment1 = Comment(comments.concept); 
    comment1.text = 'seed'; 
    comment1.source = 'election'; 
    comment1.createdOn = new DateTime.now(); 
    comments.add(comment1); 
 
    var comment2 = Comment(comments.concept); 
    comment2.text = 'river'; 
    comment2.source = 'tape'; 
    comment2.createdOn = new DateTime.now(); 
    comments.add(comment2); 
 
    var comment3 = Comment(comments.concept); 
    comment3.text = 'darts'; 
    comment3.source = 'rice'; 
    comment3.createdOn = new DateTime.now(); 
    comments.add(comment3); 
 
  } 
 
  void initQuestions() { 
    var question1 = Question(questions.concept); 
    question1.type = 'pattern'; 
    question1.text = 'notch'; 
    question1.response = 'sentence'; 
    question1.createdOn = 'agile'; 
    question1.points = 843.4028663762745; 
    questions.add(question1); 
 
    var question2 = Question(questions.concept); 
    question2.type = 'camping'; 
    question2.text = 'university'; 
    question2.response = 'children'; 
    question2.createdOn = 'beans'; 
    question2.points = 340; 
    questions.add(question2); 
 
    var question3 = Question(questions.concept); 
    question3.type = 'tax'; 
    question3.text = 'thing'; 
    question3.response = 'hat'; 
    question3.createdOn = 'seed'; 
    question3.points = 72; 
    questions.add(question3); 
 
  } 
 
  // added after code gen - begin 
 
  // added after code gen - end 
 
} 
 
