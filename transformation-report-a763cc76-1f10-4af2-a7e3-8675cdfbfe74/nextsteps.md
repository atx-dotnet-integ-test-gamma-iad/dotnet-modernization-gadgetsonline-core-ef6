# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version, update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that core functionality behaves as it did prior to the migration.

### 5. Run Existing Tests

If the solution contains any test projects, execute them to validate that existing behavior has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` namespace usage, which is not available in cross-platform .NET
- `HttpContext` and related types, which should now come from `Microsoft.AspNetCore.Http`
- Windows-specific APIs such as the registry or certain `System.Drawing` features
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`

### 7. Verify Static Files and Configuration

Ensure that files such as `appsettings.json`, `wwwroot` content, and any other static assets are present and correctly referenced. Configuration that previously resided in `Web.config` should now be represented in `appsettings.json` and wired up through the ASP.NET Core configuration system.

### 8. Test on Target Platform

If the intent of the migration is to run on a non-Windows platform, test the application explicitly on that platform (Linux or macOS) to surface any remaining platform-specific dependencies.

## Deployment

### 1. Publish the Application

Use the following command to publish a self-contained or framework-dependent release build:

```bash
# Framework-dependent
dotnet publish --configuration Release --output ./publish

# Self-contained (example for Linux x64)
dotnet publish --configuration Release --runtime linux-x64 --self-contained true --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all required files are present, including configuration files and static assets.

### 3. Configure the Web Server

Deploy the published output to your target web server. For ASP.NET Core applications, configure the server as follows:

- **IIS**: Install the [.NET Hosting Bundle](https://dotnet.microsoft.com/en-us/download) and configure the site to use the ASP.NET Core Module.
- **Nginx / Apache on Linux**: Configure a reverse proxy to forward requests to the Kestrel process, and set up a process manager such as `systemd` to keep the application running.

### 4. Validate the Deployed Application

After deployment, perform a smoke test by navigating to the application's URL and verifying that key pages and features load correctly. Check application logs for any runtime errors that did not surface during local testing.