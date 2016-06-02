//= require jquery

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