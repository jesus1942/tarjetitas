BEGIN;

CREATE TABLE students (
  id UUID PRIMARY KEY,
  external_code VARCHAR(64) UNIQUE NOT NULL,
  first_name VARCHAR(120) NOT NULL,
  last_name VARCHAR(120) NOT NULL,
  document_number VARCHAR(32),
  grade VARCHAR(64),
  section VARCHAR(64),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE student_devices (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  device_label VARCHAR(120) NOT NULL,
  device_fingerprint VARCHAR(255) NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  last_seen_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE operators (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(160) NOT NULL,
  role VARCHAR(40) NOT NULL CHECK (role IN ('admin', 'operator', 'viewer')),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE stations (
  id UUID PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  location_label VARCHAR(160) NOT NULL,
  device_fingerprint VARCHAR(255),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE meal_services (
  id UUID PRIMARY KEY,
  code VARCHAR(40) UNIQUE NOT NULL,
  name VARCHAR(120) NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE student_entitlements (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  meal_service_id UUID NOT NULL REFERENCES meal_services(id),
  valid_from DATE NOT NULL,
  valid_until DATE,
  weekly_schedule JSONB NOT NULL DEFAULT '[]'::jsonb,
  notes TEXT,
  status VARCHAR(30) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'blocked', 'paused', 'expired')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE issued_credentials (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  student_device_id UUID REFERENCES student_devices(id),
  entitlement_id UUID NOT NULL REFERENCES student_entitlements(id),
  token_hash VARCHAR(255) NOT NULL UNIQUE,
  nonce VARCHAR(128) NOT NULL,
  issued_at TIMESTAMPTZ NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE meal_redemptions (
  id UUID PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  entitlement_id UUID NOT NULL REFERENCES student_entitlements(id),
  meal_service_id UUID NOT NULL REFERENCES meal_services(id),
  service_date DATE NOT NULL,
  station_id UUID REFERENCES stations(id),
  operator_id UUID REFERENCES operators(id),
  issued_credential_id UUID REFERENCES issued_credentials(id),
  redemption_status VARCHAR(30) NOT NULL CHECK (redemption_status IN ('approved', 'rejected', 'reversed')),
  rejection_reason VARCHAR(120),
  redeemed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX uniq_redemption_per_service_day
  ON meal_redemptions (student_id, meal_service_id, service_date)
  WHERE redemption_status = 'approved';

CREATE TABLE audit_events (
  id UUID PRIMARY KEY,
  actor_type VARCHAR(30) NOT NULL CHECK (actor_type IN ('student', 'operator', 'system')),
  actor_id UUID,
  event_type VARCHAR(80) NOT NULL,
  entity_type VARCHAR(80) NOT NULL,
  entity_id UUID,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMIT;
