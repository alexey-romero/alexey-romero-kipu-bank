# 🏦 KIPU Bank - Alexey Romero

Kipu Bank es un contrato inteligente descentralizado que funciona como una bóveda de ahorros personal en la blockchain de Ethereum. Permite a los usuarios depositar y retirar ETH de forma segura, aplicando reglas claras como un límite máximo por retiro y un tope de capital total para todo el banco, garantizando un entorno controlado y predecible.

## 🧠 ¿Qué hace el contrato?
- Bóveda Personal: Cada usuario tiene un saldo de ahorros asociado a su dirección de billetera.
- Depósitos Seguros: Permite a los usuarios depositar ETH en su bóveda de forma sencilla.
- Retiros Controlados: Los usuarios pueden retirar fondos, pero con un límite fijo por transacción, lo que protege contra retiros masivos inesperados.
- Capital Máximo Global: El contrato tiene un límite de capital total (i_capitalDelBanco) que no puede ser excedido, aportando una capa adicional de seguridad y control de riesgos.
- Registro de Transacciones: Emite eventos (Deposito, Retiro) para cada operación exitosa, facilitando el seguimiento del historial de transacciones fuera de la cadena.
- Estadísticas: Lleva un registro público del número total de depósitos.
    
## 🚀 Instrucciones de despliegue
A modo de prueba, siguiendo la cronología del curso, lo ideal es desplegar el contrato utilizando Remix IDE, en la testnet Sepolia.

## 💻 Cómo interactuar con el contrato

**Importante:** las unidades de medida son en Wei. Se pueden hacer las conversiones con [esta herramienta](https://eth-converter.com/).

El contrato KipuBanco requiere dos argumentos en su constructor para ser desplegado:

- _limiteDeposito: El monto máximo total de ETH que se puede depositar en el banco (nuevamente, en Wei).
- _limiteRetiroPorTransaccion: El monto máximo de ETH que se puede retirar en una sola transacción (nuevamente, en Wei).

### Depositar fondos
Para depositar fondos, llama a la función `depositar()` enviando ETH (en Wei, o la unidad que se elija en Remix) en la transacción a través del campo `value`.

### Retirar Fondos 
Para retirar fondos, llama a la función `retirar()` especificando el monto que deseas sacar de tu bóveda personal.

### Consultar Información
Un punto muy importante de estas funciones es que, al ser de tipo    `view`, no consumen gas.