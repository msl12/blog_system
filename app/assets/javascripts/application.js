//= require jquery

// Put your application scripts here
$(function(){
  // response search query on main nav both mouse click and keyboard return key
  $('button#search-button').click(function() {
    var keyword = $.trim($('input#search-box').val());
    if (keyword != null && keyword != '') {
      $('form#cse-search-box').submit();
    }
  });
  
  $('input#search-box').keyup(function(event) {
    if (event.keyCode == 13) {
      var keyword = $.trim($('input#search-box').val());
      if (keyword != null && keyword != '') {
        $('form#cse-search-box').submit();
      }
    }
  });
});

// filter illegal tag, only number, underscore, alphabet and chinese words, add #, + like C#, C++
filterTags = function(tags) {
  var newArray = new Array();
  if (tags != null && tags.length >0) {
    var re_tag = new RegExp("^(?!_)(?!.*?_$)[\+#a-zA-Z0-9_ \u4e00-\u9fa5]+$");
    var tag_list = tags.split(/\s*,\s*/);
    for(var i = 0; i< tag_list.length; i++) {
        if (re_tag.test(tag_list[i])){
          newArray.push(tag_list[i]);
      }
    }
  }
  return newArray;
};