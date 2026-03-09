# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform target, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only framework such as `net48`, the migration to cross-platform .NET is not yet complete.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and address them before proceeding.

### 6. Check for Runtime Dependencies

Some legacy .NET Framework libraries may have compiled successfully but rely on Windows-specific APIs at runtime (e.g., `System.Web`, registry access, COM interop). Test the application on a non-Windows platform if cross-platform execution is a requirement, or review usages of the following common problem areas:

- `System.Web` namespace (not available in .NET Core and later)
- `HttpContext` usage outside of ASP.NET Core middleware
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows registry access via `Microsoft.Win32`

### 7. Review `appsettings.json` and Configuration

Legacy projects often use `Web.config` or `App.config`. Confirm that all configuration values have been migrated to `appsettings.json` and that the application reads them correctly using `IConfiguration`.

### 8. Validate Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder and are being served correctly by the ASP.NET Core static files middleware.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder and confirm all required files are present.

### 10. Deploy

Copy the contents of the `./publish` folder to the target hosting environment. Confirm the runtime environment has the appropriate .NET SDK or runtime version installed:

```bash
dotnet --version
```

If deploying to IIS, ensure the ASP.NET Core Hosting Bundle is installed on the server and that the application pool is configured to use **No Managed Code**.