Given('eu estou na página de cadastro de clientes') do
  visit '/clientes/new'
end

When('preencho o formulário com nome {string}, data de nascimento {string}, CPF {string} e e-mail {string}') do |nome, data_nascimento, cpf, email|
  fill_in 'cliente[nome_completo]', with: nome
  fill_in 'cliente[data_nascimento]', with: data_nascimento
  fill_in 'cliente[cpf]', with: cpf
  fill_in 'cliente[email]', with: email
end

When('eu clico no botão Create Cliente') do
  click_button "Create Cliente"
end

Then('eu vejo o cliente {string} cadastrado') do |string|
  expect(page).to have_content(string)
end

When('eu clico no botão Update Cliente') do
  click_button "Update Cliente"
end

Given('existe um cliente cadastrado com nome {string}') do |nome_cliente|
  visit '/clientes/new'
  fill_in 'cliente[nome_completo]', with: nome_cliente
  fill_in 'cliente[data_nascimento]', with: '1990-01-01'
  fill_in 'cliente[cpf]', with: '12345678901'
  fill_in 'cliente[email]', with: 'cliente@example.com'
  click_button 'Create Cliente'
end

When('eu atualizo o formulário com nome {string} e e-mail {string}') do |novo_nome, novo_email|
  fill_in 'cliente[nome_completo]', with: novo_nome
  fill_in 'cliente[email]', with: novo_email
end

When('eu preencho o formulário com nome {string}, data de nascimento {string}, CPF inválido {string} e e-mail {string}') do |nome, data_nascimento, cpf_invalido, email|
  fill_in 'cliente[nome_completo]', with: nome
  fill_in 'cliente[data_nascimento]', with: data_nascimento
  fill_in 'cliente[cpf]', with: cpf_invalido
  fill_in 'cliente[email]', with: email
end

Then('devo ver uma mensagem de erro informando que o CPF deve conter {int} dígitos numéricos') do |quantidade_digitos|
  expect(page).to have_content("deve conter #{quantidade_digitos} dígitos numéricos")
end

When('preencho o formulário com nome {string}, data de nascimento {string}, CPF {string} e e-mail inválido {string}') do |nome, data_nascimento, cpf, email_invalido|
  fill_in 'cliente[nome_completo]', with: nome
  fill_in 'cliente[data_nascimento]', with: data_nascimento
  fill_in 'cliente[cpf]', with: cpf
  fill_in 'cliente[email]', with: email_invalido
end

Then('devo ver uma mensagem de erro informando que o e-mail é inválido') do
  expect(page).to have_content("Email inválido")
end

Given('estou na lista de clientes cadastrados') do
  visit '/clientes'
end

When('clico no botão {string} do cliente') do |botao, nome_cliente|
  within('.cliente-row', text: nome_cliente, wait: 5) do
    click_button(botao)
  end
end

Given('eu clico na opção Editar') do
  click_on "Editar"
end

Then('o cliente {string} deve constar na lista de clientes cadastrados') do |string|
  expect(page).to have_content(string)
end


Then('o cliente {string} não deve constar na lista de clientes cadastrados') do |nome_cliente|
  expect(page).not_to have_content(nome_cliente)
end

Given('eu vejo {string} e clico em Visualizar Cliente') do |string|
  visit '/clientes'
  expect(page).to have_content(string)
  click_on "Visualizar Cliente"
end

When('clico no botão Deletar do cliente') do
  click_button "Deletar"
end


