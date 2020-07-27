<%= form_tag login_user_path, method: :post do%>
    <%= label_tag :username %><br>
    <%= text_field_tag :name %>
    <%= password_field_tag :password %>
    <%= submit_tag "Log in"%>
<% end%>