//= require jquery
//= require bootstrap-sprockets

function openModal(modal, onOpen) {
  $(modal).on('shown.bs.modal', onOpen).modal('show');
}

function showError(message, timeout) {
  __showMessage(__prepareMessage(), 'alert-danger', message, timeout)
}

function showInfo(message, timeout) {
  __showMessage(__prepareMessage(), 'alert-success', message, timeout)
}

function showWarning(message, timeout) {
  __showMessage(__prepareMessage(), 'alert-warning', message, timeout)
}

function __prepareMessage() {
  return $('#alerts');
}

function __showMessage(alert_scope, alert_type, message, timeout) {
  $('.' + alert_type + ' div:first', alert_scope).html(message);
  $('.' + alert_type, alert_scope).show('fade');
}

function __hideMessage(message_container) {
  $(message_container).hide('fade');
}
