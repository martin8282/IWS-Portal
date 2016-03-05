//= require jquery
//= require bootstrap-sprockets
//= require jquery.loadmask

function loadContainer(container, url, onComplete) {
  $('body').mask();
  $(container).load(url, function() { $('body').unmask(); if (onComplete != undefined) onComplete(); });
}

function openModal(modal, onOpen) {
  $(modal).on('shown.bs.modal', onOpen).modal('show');
}

function showError(message, timeout) {
  __showMessage(__prepareMessage(), 'alert-danger', message, timeout)
}

function showInfo(message) {
  __showMessage(__prepareMessage(), 'alert-success', message, 2000);
}

function showWarning(message, timeout) {
  __showMessage(__prepareMessage(), 'alert-warning', message, timeout)
}

function __prepareMessage() {
  return $('#alerts');
}

function __showMessage(alert_scope, alert_type, message, timeout) {
  var message_contaner = $('.' + alert_type, alert_scope);

  $('div:first', message_contaner).html(message);
  message_contaner.show('fade');
  if (timeout !== undefined) setTimeout(function() { __hideMessage(message_contaner); }, timeout);
}

function __hideMessage(message_container) {
  $(message_container).hide('fade');
}
