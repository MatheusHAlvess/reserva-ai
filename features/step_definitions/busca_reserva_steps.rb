Given('eu estou na tela de busca de reservas') do
  visit '/reserva/buscar'
end

Given('e existe reservas cadastradas para um cliente com CPF {string}') do |string|
  visit '/clientes/new'
  fill_in 'cliente[nome_completo]', with: 'Fabia'
  fill_in 'cliente[data_nascimento]', with: '2003-05-01'
  fill_in 'cliente[cpf]', with: string
  fill_in 'cliente[email]', with: 'cliente@gmail.com'
  click_button 'Create Cliente'

  visit new_reserva_path
  select 'Fabia', from: 'Cliente'
  select 1, from: 'Quarto'
  fill_in 'Entrada', with: '2023-09-01'
  fill_in 'Saida', with: '2023-10-01'
  click_button 'Reservar quarto'
end

When('eu informo o CPF {string} e clico em Buscar') do |string|
  visit '/reserva/buscar'
  fill_in 'cpf', with: string
  click_button 'Buscar'
end

Then('o sistema deve retornar as reservas encontradas na lista de resultados') do
  expect(page).to have_content("Resultado da Busca de Reservas")
end

Given('nao existe um cliente cadastrado com CPF {string}') do |string|
  visit '/clientes'
  expect(page).not_to have_content(string)
end

Then('o sistema deve mostrar que nenhuma reserva encontrada para o CPF') do
  expect(page).to have_content("Nenhuma reserva encontrada para o CPF informado e o intervalo de datas especificado.")
end

When('eu informo a data de incio {string} e de fim {string} e clico em Filtrar') do |data_inicio, data_fim|
  fill_in 'data_inicio', with: data_inicio
  fill_in 'data_fim', with: data_fim
  click_button 'Filtrar'
end

Given('e existe reservas cadastradas para um cliente com CPF {string} com data de incio {string} e de fim {string}') do |cpf, data_inicio, data_fim|
  visit '/clientes/new'
  fill_in 'cliente[nome_completo]', with: 'Fabia'
  fill_in 'cliente[data_nascimento]', with: '2003-05-01'
  fill_in 'cliente[cpf]', with: cpf
  fill_in 'cliente[email]', with: 'cliente@gmail.com'
  click_button 'Create Cliente'

  visit new_reserva_path
  select 'Fabia', from: 'Cliente'
  select 1, from: 'Quarto'
  fill_in 'Entrada', with: data_inicio
  fill_in 'Saida', with: data_fim
  click_button 'Reservar quarto'
end

Then('o sistema deve mostrar que nenhuma reserva encontrada para o CPF naquele periodo informado') do
  expect(page).to have_content("Nenhuma reserva encontrada para o CPF informado e o intervalo de datas especificado.")
end


