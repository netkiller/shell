cat >> /etc/profile.d/gradle.sh <<'EOF'
export GRADLE_HOME=/srv/gradle
export PATH=$GRADLE_HOME/bin:$PATH
EOF

source /etc/profile.d/gradle.sh