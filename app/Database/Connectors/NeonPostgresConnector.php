<?php

namespace App\Database\Connectors;

use Illuminate\Database\Connectors\PostgresConnector;

class NeonPostgresConnector extends PostgresConnector
{
    /**
     * Add Neon-specific connection options for runtimes with older libpq/SNI support.
     */
    protected function getDsn(array $config)
    {
        $dsn = parent::getDsn($config);
        $endpoint = $config['endpoint'] ?? $this->extractEndpointFromHost($config['host'] ?? null);

        if (!$endpoint || str_contains($dsn, 'options=')) {
            return $dsn;
        }

        return $dsn . ";options='endpoint={$endpoint}'";
    }

    private function extractEndpointFromHost(?string $host): ?string
    {
        if (!$host || !str_contains($host, '.neon.tech')) {
            return null;
        }

        return strtok($host, '.');
    }
}
