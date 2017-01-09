/* eslint-disable */
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.GroupSecretEditForm = (function() {
    function GroupSecretEditForm() {
      this.toggleCheckbox = bind(this.toggleCheckbox, this);
      this.removeEventListeners();
      this.initEventListeners();
    }

    GroupSecretEditForm.prototype.removeEventListeners = function() {
      return $(document).off('change', '.js-custom-group-event');
    };

    GroupSecretEditForm.prototype.initEventListeners = function() {
      return $(document).on('change', '.js-custom-group-event', this.toggleCheckbox);
    };

    GroupSecretEditForm.prototype.toggleCheckbox = function(e) {
      var $checkbox, $parent;
      $checkbox = $(e.currentTarget);
      $parent = $checkbox.closest('.checkbox');
      if ($checkbox.prop("checked")) $("#group-secret-holder").show();
      else $("#group-secret-holder").hide();
    };


    return GroupSecretEditForm;

  })();

  this.GroupSecretDialog = (function() {
    function GroupSecretDialog(){
      this.toggleCheckbox = bind(this.toggleCheckbox, this);
      this.removeEventListeners();
      this.initEventListeners();
    }

    GroupSecretDialog.prototype.removeEventListeners = function() {
      return $(document).off('click', '.js-custom-secret-button-event');
    };

    GroupSecretDialog.prototype.initEventListeners = function() {
      return $(document).on('click', '.js-custom-secret-button-event', this.click);
    };

    GroupSecretDialog.prototype.click = function(e) {
      var secret = prompt("Enter secret");
      if (secret != null){
        $("#secret").val(secret);
        $("#secret-form").submit();
      }

    };

      return GroupSecretDialog;

  })();


  $(document).ready(function(){
    if ($("#group_request_access_with_secret_enabled").prop("checked")) $("#group-secret-holder").show();
    else $("#group-secret-holder").hide();
  });
}).call(this);
