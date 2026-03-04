# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

---

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need updating.

---

### 2. Build the Solution

Perform a clean build to confirm the absence of errors in a fresh build context:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, obsolete APIs, or platform compatibility.

---

### 3. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality is preserved:

```bash
dotnet test --configuration Release
```

Review test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

---

### 4. Verify Runtime Behavior

Launch the application locally and exercise the core workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Specifically verify:
- Database connectivity and any Entity Framework migrations, if applicable.
- Any file system paths that were previously Windows-specific (e.g., backslash-separated paths). Replace these with `Path.Combine()` or forward-slash equivalents.
- Any use of `Windows Registry`, COM interop, or Windows-only APIs that may have been carried over. These will fail silently at runtime if not caught at build time.

---

### 5. Check Configuration Files

Review `appsettings.json` or any `web.config` / `app.config` files that may have been migrated:

- Ensure connection strings are valid for the target environment.
- Confirm that any environment-specific settings (e.g., paths, endpoints) are correctly parameterized.
- If `web.config` transforms were used previously, verify that the equivalent configuration is handled through `appsettings.{Environment}.json`.

---

### 6. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to the intended version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it uses the appropriate SDK:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

---

### 7. Audit Third-Party Package Compatibility

Run the following to check for outdated or vulnerable packages:

```bash
dotnet list package --outdated
dotnet list package --vulnerable
```

Update packages where necessary, particularly those that previously targeted `.NET Framework` and may now have newer cross-platform versions available.

---

### 8. Deployment

Once all validation steps pass:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Verify the contents of the `./publish` directory are complete.
3. Deploy the published output to the target server or hosting environment, ensuring the correct .NET runtime version is installed on that machine.