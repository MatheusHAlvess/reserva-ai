Given('estou na pagina de cadastro de reservas') do
  visit new_reserva_path
end

When('preencho o formulario com cliente {string}, quarto {int}, data de entrada {string} e saida {string}') do |nome_completo, quarto, entrada, saida|
  select nome_completo, from: 'Cliente'
  select quarto, from: 'Quarto'
  fill_in 'Entrada', with: entrada
  fill_in 'Saida', with: saida
end

When('eu clico no botao Reservar quarto') do
  click_button 'Reservar quarto'
end

Then('eu vejo a reserva do quarto {int} cadastrada no nome de {string}') do |quarto, nome_completo|
  expect(page).to have_content(quarto)
  expect(page).to have_content(nome_completo)
end

Given('o quarto {int} esta reservado para {string}, com entrada em {string} e saida {string}') do |quarto, nome_completo, entrada, saida|
  visit new_reserva_path
  select nome_completo, from: 'Cliente'
  select quarto, from: 'Quarto'
  fill_in 'Entrada', with: entrada
  fill_in 'Saida', with: saida
  click_button 'Reservar quarto'
end

Given('estou na lista de reservas') do
  visit reservas_path
end

When('eu clico na opcao Visualizar reserva') do
  click_link 'Visualizar reserva'
end

When('eu atualizo o formulario com a entrada {string}') do |nova_entrada|
  fill_in 'Entrada', with: nova_entrada
end

Then('o quarto {int} deve estar reservado para {string}') do |novo_quarto, nome_completo|
  expect(page).to have_content(novo_quarto)
  expect(page).to have_content(nome_completo)
end

Then('devo ver uma mensagem de erro informando que a data {string} e invalida') do |data|
  if data.include? 'Entrada'
    expect(page).to have_content('Entrada deve ser futura a hoje')
  end
  if data.include? 'Saida'
    expect(page).to have_content('Saida deve ser futura a entrada')
  end
end

Then('devo ver uma mensagem de erro informando que o quarto {int} ja esta reservado de {string} ate {string}') do |quarto, entrada, saida|
  eformat = Date.parse(entrada).strftime('%d/%m/%Y')
  sformat = Date.parse(saida).strftime('%d/%m/%Y')
  expect(page).to have_content("Quarto #{quarto} ja esta reservado de #{eformat} ate #{sformat}")
end

When('eu clico no botao Deletar') do
  click_on 'Deletar'
end

Then('a reserva do quarto {int} de {string} nao deve constar na lista de reservas') do |quarto, nome_completo|
  expect(page).not_to have_content("Quarto: #{quarto}")
  expect(page).not_to have_content("Cliente: #{nome_completo}")
end