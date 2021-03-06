for n in `seq 1 100`; do
  if [ -f /tmp/vcap_chown.out ]; then
    break
  fi
  sleep 0.1
done

export ERLANG_HOME=/var/vcap/packages/erlang
export PATH=/var/vcap/packages/erlang/bin:$PATH
export HOME=/store/instance
export RABBITMQ_NODENAME="$1@localhost"
export RABBITMQ_NODE_PORT=10001
export RABBITMQ_BASE=/store/instance
export RABBITMQ_LOG_BASE=/store/log
export RABBITMQ_MNESIA_DIR=/store/instance/mnesia
export RABBITMQ_PLUGINS_EXPAND_DIR=/store/instance/plugins
export RABBITMQ_CONFIG_FILE=/store/instance/config/rabbitmq
export RABBITMQ_ENABLED_PLUGINS_FILE=/store/instance/config/enabled_plugins
export RABBITMQ_SERVER_START_ARGS="-smp disable"
export RABBITMQ_CONSOLE_LOG=reuse
export ERL_CRASH_DUMP="/dev/null"
export ERL_CRASH_DUMP_SECONDS="1"
exec start-stop-daemon --start --quiet --chuid vcap --exec /var/vcap/packages/rabbitmq/sbin/rabbitmq-server >/store/log/rabbitmq_stdout.log 2>/store/log/rabbitmq_stderr.log
