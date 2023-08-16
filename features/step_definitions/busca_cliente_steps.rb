Given('que eu seja usuario do sistema') do
  visit '/clientes/new'
  fill_in 'cliente[nome_completo]', with: 'Cliente Exemplo'
  fill_in 'cliente[data_nascimento]', with: '2003-05-01'
  fill_in 'cliente[cpf]', with: '03135892751'
  fill_in 'cliente[email]', with: 'cliente@example.com'
  click_button 'Create Cliente'
end

When('o usuario busca por um cliente com o email {string}') do |email|
  visit '/cliente/buscar'
  fill_in 'termo', with: email
  click_button 'Buscar'

end

Then('o sistema exibe as informacoes do cliente {string}') do |nome|
  expect(page).to have_content(nome)
  # Implemente mais expectativas aqui para verificar as informações exibidas
end

When('o usuario busca por um cliente com o nome {string}') do |nome|
  visit '/cliente/buscar'
  fill_in 'termo', with: nome
  click_button 'Buscar'
end

When('o usuario busca por um cliente com o CPF inexistente {string}') do |cpf|
  visit '/cliente/buscar'
  fill_in 'termo', with: cpf
  click_button 'Buscar'
end

When('o usuario busca por um cliente com o CPF valido {string}') do |cpf|
  visit '/cliente/buscar'
  fill_in 'termo', with: cpf
  click_button 'Buscar'
end

Then('o sistema exibe uma mensagem de cliente não encontrado') do
  expect(page).to have_content('Nenhum cliente encontrado.')
end
