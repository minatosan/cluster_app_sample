$(document).on('turbolinks:load',function(){
    var re = new RegExp('/articles/[0-9]+/edit$');
    if(!re.test(location.pathname)) {
   return;
    }
   let fileIndex = $(".preview").length;
   function buildHTML(num){
     var html=`<div class = "img-view">
     <img class="preview" width="150px" height="150px" data-index="${num}">
     <div class="btn-wrapper">
       <div class="btn-edit">編集</div>
       <div class="btn-delete">削除</div>
       <textarea name="article[article_images_attributes][${fileIndex}][introduction]"rows="4" cols="40"></textarea>
     </div>
     
   </div>`;
   fileIndex += 1
   return html
   }
    
   $('.preview').each(function(index, box){
    $(box).attr('id', `preview__${index}`);
  })
  //削除ボタンにidを追加
  $('.btn-delete').each(function(index, box){
    $(box).attr('id', `btn-delete__${index}`);
  })
  
  $(".article-new-file-field").on('change', 'input[type="file"]', function() {
    changed_input = $(this).parent().data('index');
    
    
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    // ファイル読み込み後の処理
    
    if($(".preview").length >= 10 ){
      return false;
    }
    else if($(`.preview[data-index=${changed_input}]`).length == 0){
      $(".article-new-preview").append(buildHTML(fileIndex));
    }
    
   
    reader.onload = function(e) {
      // img_view内のimgタグのsrcプロパティへ、読み込みが完了した画像を入れ込む
      $(".img-view").find(`.preview[data-index=${changed_input}]`).attr('src', e.target.result);
    };

    // FileReaderオブジェクトへ属性値(filesプロパティ)を代入する
    reader.readAsDataURL(file);

   

   
    var img_number =$(".article-new-input").length;
    
  })

  $(".article-edit-file-field").on('change', 'input[type="file"]', function() {
    changed_input = $(this).parent().data('index');
    
    var file = $(this).prop('files')[0];
    
    var reader = new FileReader();
    // ファイル読み込み後の処理
    
     reader.onload = function(e) {
      // img_view内のimgタグのsrcプロパティへ、読み込みが完了した画像を入れ込む
      $(".img-view").find(`.preview[data-index=${changed_input}]`).attr('src', e.target.result);
    };
    reader.readAsDataURL(file);
    if($(".preview").length >= 10 ){
      return false;
    }
    else if($(`.preview[data-index=${changed_input}]`).length == 0){
      $(".article-new-preview").append(buildHTML(fileIndex));
    }
    
    var new_input = $(`<div class = "article-edit-input" data-index="${fileIndex}">

    <input class="upload-image" type="file" accept="image/jpg,image/jpeg,image/png"
    name="article[article_images_attributes][${fileIndex}][picture]">
                       </div>`
    );
    
    

    if($(".article-edit-input").length ==1){
      $(".article-edit-file-field").append(new_input);
    }else if($(".preview").length >= 10){
      return false;
    }else if($(".upload-image").length==$(".preview").length){
      $(".article-edit-file-field").append(new_input);
    }
    
   
   

    // FileReaderオブジェクトへ属性値(filesプロパティ)を代入する
   

   
    var img_number =$(".article-new-input").length;
 
    
  })
  $(document).on('click', '.btn-delete', function() {
    var new_input = $(`<div class = "article-edit-input" data-index="${fileIndex}">

    <input class="upload-image" type="file" accept="image/jpg,image/jpeg,image/png"
    name="article[article_images_attributes][${fileIndex}][picture]">
                       </div>`
    );  

    var target_image = $(this).parent().parent();
    var remove_id = target_image.find(".preview").data('index');
    var remove_image= $('.article-new-input[data-index='+remove_id+']');
    var remove_edit=$('.article-edit-input[data-index='+remove_id+']');
    
    //editでの削除機能  修正
    if($(".preview").length ==  10){
      target_image.remove();
      remove_edit.remove();
      $(".article-edit-file-field").append(new_input);
    }
    else{
    target_image.remove();
    remove_edit.remove();}
    if($(`#article_article_images_attributes_${remove_id}__destroy`).length){
      $(`#article_article_images_attributes_${remove_id}__destroy`).prop('checked',true);
      remove_image.hide();
    }else{
      remove_image.remove();
    };
   
  });
});
