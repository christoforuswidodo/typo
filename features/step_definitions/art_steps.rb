Given /the following (.*?) exist:$/ do |type, table|
    table.hashes.each do |element|
        if type == "articles" then Article.create(element)
        elsif type == "users" then User.create(element)
        elsif type == "comments" then Comment.create(element)
        end
    end
end

Given /I log in using username "(.*?)" with password "(.*?)"/ do |usr, pass|
    visit '/accounts/login'
    fill_in "user_login", with: usr
    fill_in "user_password", with: pass
    click_button 'Login'
    assert page.has_content? 'successful'
end

Then /author "(.*?)" should have (\d+) article/ do |aut, num|
    assert Article.find_all_by_author(User.find_by_name(user).login).size == Integer(count)
end

Given /the articles with ids "(\d+)" and "(\d+)" were merged$/ do |id1, id2|
  article = Article.find_by_id(id1)
  article.merge_with(id2)
end