# VMs KVM

## Esse projeto configura o ambiente para rodar o qemu com e sem kvm.

Faça o clone do projeto para um diretorio de sua escolha com o usuário root ( su - root / sudo -i ).

```
# git clone https://gitlab.ic.unicamp.br/william/vms-kvm.git
```

Preparar o ambiente: 

```
# cd vms-kvm
# bash ./make-env.sh
```

Se a mensagem final for : Você possui suporte a KVM ;) ( então você possui virtualização assistida em hardware HVM )
Agora se a mensagem for : Você NAO tem suporte a KVM, pode utilizar emulação ou tentar habilitar na BIOS ( então você terá que utilizar emulação ou tentar verificar na Bios de sua maquina se tem a solução ou se for VM tera que aninhar o KVM)

**Atenção:** Agora você deve deslogar como root e depois logar novamente su - root / sudo -i 
Isso é necessário para carregar o PATH.

Para criar uma VM simples com apenas uma unica interface de rede:

```
# create-single-vm.sh NOME-DA-VM ID
```

**NOME-DA-VM** : Nome como quer chamar a VM, isso deve ser unico na criação de mais de uma vm.
**ID** (00 até ff): Número unico também que será colocado com o endereço MAC final da VM aa:00:00:11:76:**ID**.
Interface de rede no host que será criada é **tap_NOME-DA-VM**

Para criar uma VM com duas interface de rede:

```
# create-vm-dual-if.sh NOME-DA-VM ID
```

**NOME-DA-VM** : Nome como quer chamar a VM, isso deve ser unico na criação de mais de uma vm.
**ID** (00 até ff): Número unico também que será colocado com o endereço MAC final da VM nas duas interface bb:00:00:11:76:**ID** e cc:00:00:11:76:**ID**.
As duas interface de rede no host que serão criadas são **tap1_NOME-DA-VM** (bb:00:00:11:76:**ID**) e **tap1_NOME-DA-VM** (cc:00:00:11:76:**ID**)

Para listar todas as VM que estão ligadas:

```
# list-vms.sh
```
Você terá como saida o nome da VM e o PID do processo que está está atribuida no sistema operacional.

Para acessar o console serial da VM onde temos um terminal linux:

```
# console.sh NOME-DA-VM
```
Para sair do console da VM, tecle ctrl + q

Para acessar o monitor do qemu da VM:

```
# monitor.sh NOME-DA-VM
```
Para sair do console da VM, tecle ctrl + q

Caso queira finalizar a VM, você pode acessar o monitor da VM e dar o comando **quit** ou **system_powerdown** ou simplesmente finalizar o processo com **kill PID-DA-VM**

Caso queira finalzar todas as VMs: 

```
# kill-vms.sh
```

Para resetar todo o ambiente em caso de falha, apague a pasta /vms-kvm e execute o primeiro passo desse tutorial.

