$(document).ready(function(){
      /* It doesn't work
      $(".editable_text").editable(submitEdit, {
          indicator : "Saving...",
          tooltip   : "Click to edit...",
          name : "title",
          id   : "article",
          type : "text"
      });*/

      function submitEdit(value, settings)
      {
          var edits = new Object();
          var origvalue = this.revert;
          var textbox = this;
          var result = value;
          edits[settings.name] = [value];
          var returned = $.ajax({
              url: "/admin/articles/5",
              type: "PUT",
              data : edits,  //"article[id]=5&article[title]="+$("#article_title").html(),
              dataType : "json",
              complete : function (xhr, textStatus)
              {
                  alert(xhr.responseText);
                  //var response =  $.secureEvalJSON(xhr.responseText);
                //  if (response.Message != "")
                //  {
                //      alert(Message);
                //  }
              }
          });
          return(result);
      };
  });


